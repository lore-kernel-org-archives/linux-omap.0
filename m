From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: lowmemory android driver not needed?
Date: Wed, 21 Jan 2009 22:13:14 -0800
Message-ID: <d6200be20901212213x1069762cpd377d04bc5a04a91@mail.gmail.com>
References: <20090114010223.GA21380@kroah.com>
	 <20090114104307.GA20451@elf.ucw.cz>
	 <20090114104834.18387fca@lxorguk.ukuu.org.uk>
	 <d6200be20901141426r1d48ea33gc9a380451e4aaf93@mail.gmail.com>
	 <20090114231739.GB24111@kroah.com>
	 <d6200be20901141532y6f236104kd521041d640c152e@mail.gmail.com>
	 <20090115001224.GC11328@kroah.com>
	 <5d5443650901150532r20a4c25q834afadde2f98a3@mail.gmail.com>
	 <2f11576a0901160342x291267cn11b33d65ec9239b4@mail.gmail.com>
	 <2f11576a0901160518g52a3e70endc98fe4792a98b9b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:40899 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbZAVGNR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 01:13:17 -0500
In-Reply-To: <2f11576a0901160518g52a3e70endc98fe4792a98b9b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>, Brian Swetland <swetland@google.com>, arve@google.com, San Mehat <san@android.com>, Robert Love <rlove@google.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?ext_Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>, viktor.rosendahl@nokia.com, Trilok Soni <soni.trilok@gmail.com>

On Fri, Jan 16, 2009 at 5:18 AM, KOSAKI Motohiro
<kosaki.motohiro@jp.fujitsu.com> wrote:
> also quick review to lowmemorykiller.c

>> static struct shrinker lowmem_shrinker =3D {
>>         .shrink =3D lowmem_shrink,
>>         .seeks =3D DEFAULT_SEEKS * 16
>> };
>
> why do you choice *16?
>

To indicate that it is more expensive to restart a killed process than
a regular cache page.

>
>> static uint32_t lowmem_debug_level =3D 2;
>> static int lowmem_adj[6] =3D {
>
> why do you choice [6]?

We use six levels.


>> static int lowmem_shrink(int nr_to_scan, gfp_t gfp_mask)
>> {
>>         struct task_struct *p;
>>         struct task_struct *selected =3D NULL;
>>         int rem =3D 0;
>>         int tasksize;
>>         int i;
>>         int min_adj =3D OOM_ADJUST_MAX + 1;
>>         int selected_tasksize =3D 0;
>>         int array_size =3D ARRAY_SIZE(lowmem_adj);
>>         int other_free =3D global_page_state(NR_FREE_PAGES) + global=
_page_state(NR_FILE_PAGES);
>
> I think you don't consider mlocked page (and/or other unevictable pag=
e).
> if much mlocked file page exist, other_free can become large value.
> then, this routine don't kill any process.
>

Yes, this is a problem we have seen, but I did not find counter for
pinned cache pages. I may be able to use NR_UNEVICTABLE if
CONFIG_UNEVICTABLE_LRU is enabled now though.

Another problem we run into is that allocations of contiguous pages
can cause kswapd to empty all the caches. This will not trigger this
lowmemorykiller or the regular oom killer.

>>         read_lock(&tasklist_lock);
>>         for_each_process(p) {
>
> Oops. too long locking.
> shrink_slab() is freqentlly called function. I don't like costly oper=
ation.
>
>>                 if(p->oomkilladj >=3D 0 && p->mm) {
>>                         tasksize =3D get_mm_rss(p->mm);
>>                         if(nr_to_scan > 0 && tasksize > 0 && p->oomk=
illadj >=3D min_adj) {
>>                                 if(selected =3D=3D NULL ||
>>                                    p->oomkilladj > selected->oomkill=
adj ||
>>                                    (p->oomkilladj =3D=3D selected->o=
omkilladj &&
>>                                     tasksize > selected_tasksize)) {
>>                                         selected =3D p;
>>                                         selected_tasksize =3D tasksi=
ze;
>>                                         lowmem_print(2, "select %d (=
%s), adj %d, size %d, to kill\n",
>>                                                      p->pid, p->comm=
, p->oomkilladj, tasksize);
>>                                 }
>>                         }
>>                         rem +=3D tasksize;
>
> this code mean,
> shrinker->shrink(0, gfp_mask) indicate to recalculate total rss every=
 time.
> it is too CPU and battery wasting.
>

How about this:
----
diff --git a/drivers/misc/lowmemorykiller.c b/drivers/misc/lowmemorykil=
ler.c
index 3715d56..3f4e41a 100644
--- a/drivers/misc/lowmemorykiller.c
+++ b/drivers/misc/lowmemorykiller.c
@@ -71,6 +71,12 @@ static int lowmem_shrink(int nr_to_scan, gfp_t gfp_m=
ask)
        }
        if(nr_to_scan > 0)
                lowmem_print(3, "lowmem_shrink %d, %x, ofree %d, ma
%d\n", nr_to_scan, gfp_mask, other_free, min_adj);
+       rem =3D global_page_state(NR_ACTIVE_ANON) +
global_page_state(NR_ACTIVE_FILE);
+       if (!nr_to_scan || min_adj =3D=3D OOM_ADJUST_MAX + 1) {
+               lowmem_print(5, "lowmem_shrink %d, %x, return %d\n",
nr_to_scan, gfp_mask, rem);
+               return rem;
+       }
+
        read_lock(&tasklist_lock);
        for_each_process(p) {
                if(p->oomkilladj >=3D 0 && p->mm) {
@@ -86,7 +92,6 @@ static int lowmem_shrink(int nr_to_scan, gfp_t gfp_ma=
sk)
                                                     p->pid, p->comm,
p->oomkilladj, tasksize);
                                }
                        }
-                       rem +=3D tasksize;
                }
        }
        if(selected !=3D NULL) {
----


--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
