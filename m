From: Maxim Podbereznyy <lisarden@gmail.com>
Subject: Re: latest kernel for am35xx
Date: Fri, 1 Jun 2012 21:23:07 +0400
Message-ID: <CAP3+TEoHUxdfFnONFk9-utH485OZ8RmhowNPr3qrYbrz2NVapw@mail.gmail.com>
References: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com>
	<CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com>
	<CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
	<20120601033605.GB520@animalcreek.com>
	<20120601162003.GA28393@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60829 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760122Ab2FARXJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jun 2012 13:23:09 -0400
Received: by ghrr11 with SMTP id r11so2274988ghr.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 10:23:08 -0700 (PDT)
In-Reply-To: <20120601162003.GA28393@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hey Mark!

I don't like to look stupid, but I don't find v3.4 tag here:
http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git;a=3Dt=
ags

please have a look at. There are only a few candidates there for the v3=
=2E4


2012/6/1 Mark A. Greer <mgreer@animalcreek.com>:
> [Somehow this didn't get out the first time so resending.]
>
> On Thu, May 31, 2012 at 08:36:05PM -0700, Mark A. Greer wrote:
>> On Thu, May 31, 2012 at 10:08:44AM +0300, Maxim Podbereznyy wrote:
>> > Hi!
>>
>> Hi Maxim
>>
>> > http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git
>> > Does anyone knows a working branch/tag for am3517evm? I need the b=
oard
>> > boots fine with Ethernet enabled and working.
>> >
>> > I read a few messages at e2e forum and all of them report about br=
oken
>> > features.. I need wl1271 support in the kernel therefore I have to=
 use
>> > on the latest kernels.
>>
>> There are several issues with the am35x code in the current communit=
y.
>> However, if you checkout k.o. v3.4, use omap2plus_defconfig, enable
>> CONFIG_TI_DAVINCI_EMAC, and add 'nohlt' to the cmdline, you will be
>> able to boot the am3517evm. =A0Don't try a Suspend-to-RAM though.
>>
>> Mark
>> --
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
