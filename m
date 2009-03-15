From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 07/12] ARM: OMAP3: mmc-twl4030 add MMC3 support
Date: Sun, 15 Mar 2009 19:27:32 +0200
Message-ID: <6ed0b2680903151027q10a0717fvf73234b2836b0064@mail.gmail.com>
References: <20090310205824.16425.97745.stgit@localhost>
	 <20090310211000.16425.62205.stgit@localhost>
	 <20090315160426.GE10786@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f175.google.com ([209.85.218.175]:49250 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZCOR1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Mar 2009 13:27:35 -0400
Received: by bwz23 with SMTP id 23so691996bwz.37
        for <linux-omap@vger.kernel.org>; Sun, 15 Mar 2009 10:27:32 -0700 (PDT)
In-Reply-To: <20090315160426.GE10786@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Sun, Mar 15, 2009 at 6:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Mar 10, 2009 at 02:10:00PM -0700, Tony Lindgren wrote:
>> ... Array size for hsmmc[] is specified
>> because hsmmc[2].name is needed for MMC3 name.
>
> I see nothing in this patch which requires that.

Right, but there is already some code in twl4030_mmc_init() of mmc-twl4=
030.c:

  struct twl_mmc_controller *twl =3D hsmmc + c->mmc - 1;
<snip>
  sprintf(twl->name, "mmc%islot%i", c->mmc, 1);

=2E. which basically writes to hsmmc[2].name for MMC3.

>> diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2=
/mmc-twl4030.c
>> index 6399874..042035c 100644
>> --- a/arch/arm/mach-omap2/mmc-twl4030.c
>> +++ b/arch/arm/mach-omap2/mmc-twl4030.c
>> @@ -62,7 +62,7 @@ static struct twl_mmc_controller {
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl_vmmc_dev_grp;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl_mmc_dedicated;
>> =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0name[HSMMC_NAME_LEN + 1];
>> -} hsmmc[] =3D {
>> +} hsmmc[OMAP34XX_NR_MMC] =3D {
>
> so this change looks like it can be omitted.

No, that would bring some painful memory corruption issues.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
