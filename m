From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: OMAP3xxx hsmmc : MMC3 doesn't work, always times out?
Date: Sat, 13 Jun 2009 14:45:59 +1200
Message-ID: <5a7b8b7b0906121945g6edfba8xd2228f31fa517749@mail.gmail.com>
References: <5a7b8b7b0906101913h2dbcbbc6l8f27873b8f81a3e0@mail.gmail.com>
	 <FCCFB4CDC6E5564B9182F639FC35608702F5345DB6@dbde02.ent.ti.com>
	 <5a7b8b7b0906102035s448e33cfpe4b321d36288e514@mail.gmail.com>
	 <1244700526.9815.31.camel@blitz>
	 <5910F919-941B-4964-99F5-C5772B1965C9@gmail.com>
	 <6ed0b2680906110229u7ce2481sddb0168829bf7d38@mail.gmail.com>
	 <8CD1B7D1-9B84-45C1-BC91-B44839743500@gmail.com>
	 <4A3202FF.9080201@nokia.com>
	 <004201c9eb74$2b7fcfa0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f214.google.com ([209.85.217.214]:53106 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbZFMCp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 22:45:57 -0400
Received: by gxk10 with SMTP id 10so4368810gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 19:45:59 -0700 (PDT)
In-Reply-To: <004201c9eb74$2b7fcfa0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

On Sat, Jun 13, 2009 at 3:40 AM, Madhusudhan<madhu.cr@ti.com> wrote:
<snip>
> Hugo,
>
> Your CLK and CMD line mux does not look correct to me.
>
> Try the below settings.
>
> MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x5d8,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPU=
T_PULLUP)
> MUX_CFG_34XX("AC3_3430_MMC3_CMD", 0x1d0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPU=
T_PULLUP)
>
> CMD1 can never go through if your MUX is wrong.
>
> Let me know if this helps.
>
> Regards,
> Madhu

Thanks Madhu. Your updated settings seem wrong to me (at least for the
way my particular board is wired). Perhaps there is a difference
between the 3430 and 3503 in this respect (I don't have the 3430
datasheet so can't check). Note I'm using MMC3_CLK and CMD that are
muxed on balls AF10 and AE10. It's a shame Gumstix chose not to
publish the Overo modules' schematics - having them would have made
this problem much easier to debug!

After some experimentation, the following mux settings are working
with my hardware:

+/* MMC3 */
+MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x5d8,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE10_3430_MMC3_CMD", 0x5da,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE11_3430_MMC3_DAT0", 0x5e4,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AH9_3430_MMC3_DAT1", 0x5e6,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE13_3430_MMC3_DAT3", 0x5e2,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)

=46or the archive, it looks like the ehci driver (which has some hackis=
h
out-of-tree patches specific to the Overo) was messing up my padconf
settings even though they were correct in u-boot. The other
possibility, is that u-boot wasn't defining the CLK signal with input
enable; this gives the following mux debug message:
MUX: setup AF10_3430_MMC3_CLK (0xd80025d8): 0x001a -> 0x011a

Thanks everyone for your help!

Hugo
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
