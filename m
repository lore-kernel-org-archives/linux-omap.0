From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: TSC2101/2102
Date: Mon, 19 Mar 2007 17:04:55 +0900
Message-ID: <010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
	<004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316074157.GA1133@bitbox.mine.nu>
	<004401c767a1$f1489590$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316094926.GA4519@bitbox.mine.nu>
	<00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319093721.bd0df13e.jarkko.nikula@nokia.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20070319093721.bd0df13e.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Jarkko Nikula' <jarkko.nikula@nokia.com>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

> 
> On Mon, 19 Mar 2007 11:02:30 +0900
> "ext Kyungmin Park" <kmpark@infradead.org> wrote:
> 
> > Ah, a few days ago, tsc2301 driver is merged in omap tree. 
> Why don't you
> > consider the tsc2301 driver too?
> 
> Hmm... from where I could find the tsc2301 driver from omap 
> tree? Just started to wonder has someone already pushed it there :-)
> 
> My copy of the tree is from 
> ftp://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma
> p-2.6.git. Is it rebased correctly? E.g. last commit in 
> master branch is from "Fri Feb 16" but "Wed Mar 7" in omap-drivers.

I usually use the omap git tree in mvista.
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-
2.6.git;a=commit;h=a7b9b17c9025066cd05f555bbba5542bcf16df3a
it was commited at Tue, 13 Mar.

> 
> We have some kind of working version of 2301 driver with 
> subdrivers separated to proper kernel directories 
> (drivers/input/touchscreen, sound/soc/codecs) but e.g. audio 
> part is not yet actual ASoC driver.
> 
> > tsc2xxx driver? I heard tsc2301 is super set of tsc210x, 
> (the bigger chip
> > number, the more functions)
> > 
> I had a short look to TSC2101 spec and at least audio parts 
> of TSC230x and TSC2101 are not compatible. Different block 
> diagrams and most/all of the audio registers.
> 
> http://www.ti.com/lit/gpn/tsc2101
> http://www.ti.com/lit/gpn/tsc2301

Yes, I knew it. I also suffered because of its different registers.

In my opinion, As OMAP CPU registers. it has common registers and chip specific
ones.
So we can define it at least headers files.

# common parts

 TSC2XXX_TS_X,
 TSC2XXX_TS_Y,

# chip specific parts
 TSC21XX_AUDIO_CTRL1.
 TSC23XX_AUDIO_CTRL1,

I will send the tsc2101 patch based on tsc2301 files. I think it's complicted
with Imre's tsc2101 patch. 

Thank you,
Kyungmin Park
