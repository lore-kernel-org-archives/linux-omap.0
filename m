From: rockefeller <rockefeller.lin@innocomm.com>
Subject: Re: [PATCH 2/9] omap: mux: Add new style pin multiplexing code for
 omap3
Date: Mon, 30 Aug 2010 09:31:13 +0800
Message-ID: <1283131873.13307.5.camel@I097020.innocomm.com>
References: <S1752576Ab0H0BhI/20100827013708Z+1681@vger.kernel.org>
	 <1282876196.13328.45.camel@I097020.innocomm.com>  <4C778455.8050108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vfe3.seed.net.tw ([139.175.252.113]:61202 "EHLO
	vfe3.seed.net.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab0H3Bak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Aug 2010 21:30:40 -0400
Received: from [210.68.184.147] (port=32464 helo=[192.168.16.64])
	by vfe3.seed.net.tw with esmtp (Seednet 4.69:1)
	id 1OptCn-000OI6-VX
	for linux-omap@vger.kernel.org; Mon, 30 Aug 2010 09:30:38 +0800
In-Reply-To: <4C778455.8050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2010-08-27 at 11:24 +0200, Cousson, Benoit wrote:
> On 8/27/2010 4:29 AM, rockefeller wrote:
> > Hi Tony,
> >     In the implementation of omap_mux_init_signal(char *muxname, int val)
> > in arch/arm/mach-omap2/mux.c, it will modify the muxname of
> > caller that passed in and not recover it, did you mean to implement
> > to do so?(I try to explain my point of view as 2 examples below).
> 
> I'm not sure it was really done on purpose. It works today because none 
> of the following cases are really happening.
> 
> >
> > [Example 1]
> > For a XIP device(NOR type), a caller function might be codeed like
> > below:
> >
> > omap_mux_init_signal("muxname.mode7", 0xFFFF);
> >
> > and in this case, the string "muxname.mode7" might be a const string
> > and not be modified.
> 
> That case seems to be a valid one.
> 
> >
> > [Example 2]
> > For a NAND device, a caller might be coded like below:
> >
> > static char *pin_mux_name = "muxname.mode7";
> >
> > function1()
> > {
> > omap_mux_init_signal(pin_mux_name, 0xFFFF);
> > }
> >
> > function2()
> > {
> > omap_mux_init_signal(pin_mux_name, 0x0000);
> > }
> >
> > void main()
> > {
> > function1();
> > function2();
> > }
> >
> > Because "muxname.mode7" in in RAM is modifiable, after function call
> > to function1(), the *pine_mux_name will be "muxname" and therefore when
> > calls to function2() to try to set this pin in mode7 with value 0x0000
> > might be un-expected result.
> 
> In theory the pin mux is done once at init time, so I'm not sure this 
> case is supposed to happen. Is it a real case?
I just encountered the issue when I ported 
http://dev.omapzoom.org/?p=modem-int/kernel.git;a=shortlog;h=refs/heads/xmm-3630
to Froyo(Android-2.6.32)
> 
> Anyway, I think that a simple strlcpy(tmp, muxname, 32) in 
> omap_mux_init_signal can fix it.
> 
> Do you mind submitting a patch to fix that?
> 
> Thanks,
> Benoit
I would like to introduce a new function omap_mux_name_strcmp() that
adapted from strcmp() as below and verified with android-2.6.32 and
it works fine.

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6c2f8f0..b61c24a 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -127,17 +127,34 @@ int __init omap_mux_init_gpio(int gpio, int val)
        return 0;
 }
 
+static int omap_mux_name_strcmp(const char * mux_name, const char
*mode_name)
+{
+       unsigned char c1, c2;
+
+       while (1) {
+               c1 = *mux_name++;
+               c2 = *mode_name++;
+               if (c1 != c2) {
+                       if ((c1 == 0 && c2 == '.') || (c1 == '.' && c2
== 0))
+                               break;
+                       else
+                               return c1 < c2 ? -1 : 1;
+               }
+               if (!c1)
+                       break;
+       }
+       return 0;
+}
+
 int __init omap_mux_init_signal(char *muxname, int val)
 {
        struct omap_mux_entry *e;
-       char *m0_name = NULL, *mode_name = NULL;
+       char *mode_name = NULL;
        int found = 0;
 
        mode_name = strchr(muxname, '.');
        if (mode_name) {
-               *mode_name = '\0';
                mode_name++;
-               m0_name = muxname;
        } else {
                mode_name = muxname;
        }
@@ -147,7 +164,7 @@ int __init omap_mux_init_signal(char *muxname, int
val)
                char *m0_entry = m->muxnames[0];
                int i;
 
-               if (m0_name && strcmp(m0_name, m0_entry))
+               if (m0_entry && omap_mux_name_strcmp(muxname, m0_entry))
                        continue;
 
                for (i = 0; i < OMAP_MUX_NR_MODES; i++) {
@@ -156,7 +173,7 @@ int __init omap_mux_init_signal(char *muxname, int
val)
                        if (!mode_cur)
                                continue;
 
-                       if (!strcmp(mode_name, mode_cur)) {
+                       if (!omap_mux_name_strcmp(mode_name, mode_cur))
{
                                u16 old_mode;
                                u16 mux_mode;

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


