From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Sun, 17 Nov 2013 23:09:41 +0100
Message-ID: <52893EA5.7080809@gmail.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>	<CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>	<527A7E20.4040107@ti.com>	<527B95E3.9060802@ti.com>	<527B9673.60400@gmail.com>	<527BAF63.10308@ti.com>	<527BB38A.1060609@gmail.com>	<527BB636.60403@ti.com> <CANacCWynOaW_xDBCiFaG5vrcTFuOkk43kuu26gvN4-eN2E8R4w@mail.gmail.com> <52863232.30207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:38414 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab3KQWJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Nov 2013 17:09:57 -0500
Received: by mail-ea0-f182.google.com with SMTP id o10so2547477eaj.27
        for <linux-omap@vger.kernel.org>; Sun, 17 Nov 2013 14:09:56 -0800 (PST)
In-Reply-To: <52863232.30207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Gururaja Hebbar <gururaja.hebbar@ti.com>, joelf@ti.com, Matt Porter <matt@ohporter.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

Hi Nishanth,

On 11/15/2013 03:39 PM, Nishanth Menon wrote:
> To trigger the fail, I created a custom Test case on TI vendor kernel
> based on v3.12 tag:
> On beagleBone-Black
> test scenario (BBB):
> 
>     Boot from SD card
>     ensure firmware is loaded (rev 0x182)
>     run LTP fsstress [1] in background on EMMC
>         mkdir -p /tmp/testing
>         mke2fs /dev/mmcblk1p1
>         mount /dev/mmcblk1p1 /tmp/testing
>         fsstress -d /tmp/testing p 4 -n 1000 -l0 -v >/dev/null &
>     run ping in the background (to add yet another interface)
>     run memtester[2] (70% of free memory)
>         memtester 343M >/dev/null &
>         sleep 10 (to allow memtester to start up properly)
>     start=`date`;i=0; while [ 1 ]; do rtcwake -d /dev/rtc0 -m mem -s
> 2; i=$((i + 1)); echo "$i: start =$start, now="`date`; sleep 2; done
> 
> Eventual hang log (using the regular suspend-resume): [3] - took close
> to two days of testing to trigger this.
> 
> Moving to a suspend_late and resume_early such as in [4], it passed
> the test for over 4 days now.

Wow, that's an intense test that you have there :)

> Daniel,
> will be good if you could post [4] for comments if you think that is
> the right thing to do and helps solve the issue you saw as  well.

Alright, will do!


Thanks a lot,
Daniel

