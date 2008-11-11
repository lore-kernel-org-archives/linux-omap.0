From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [BRIDGE] bridgedriver load/unload problem
Date: Tue, 11 Nov 2008 13:26:11 +0200 (EET)
Message-ID: <20081111.132611.180686770.Hiroshi.DOYU@nokia.com>
References: <20081110.135917.46194187.Hiroshi.DOYU@nokia.com>
	<3a2dabf50811102248j27be7ca4tb8ba4dc8910e1d7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18492 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbYKKL02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 06:26:28 -0500
In-Reply-To: <3a2dabf50811102248j27be7ca4tb8ba4dc8910e1d7c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grgupta77@gmail.com
Cc: x0023949@ti.com, linux-omap@vger.kernel.org, vpasam@ti.com

Hi Ramesh,

From: "ext Ramesh Gupta Guntha" <grgupta77@gmail.com>
Subject: Re: [BRIDGE] bridgedriver load/unload problem
Date: Tue, 11 Nov 2008 12:18:34 +0530

> I am not able to reproduce this issue. Is it consistent at your end?

Not conconsistent, but eventually it encounters with:

while true
do
	./test.sh
done

$ cat test.sh
echo 8 > /proc/sys/kernel/printk
modprobe bridgedriver \
    phys_mempool_base=0x87a00000 phys_mempool_size=0x600000 \
    GT_str="**=01234567" \
    && ./cexec.out -T ./ddspbase_tiomap3430.dof64P \
    && ./ping.out 1 \
    && rmmod bridgedriver

> What is the bridge patch set you are using for this?

- "tidspbridge-20081107.tgz"
- omap3430 SDP board
- the latest l-o

the log for SDP is located on:

  http://4869037.web.fc2.com/bridge-unload-sdp.txt

>From the above log, IRQ comes from DSP exact during unloading module.

  Hiroshi DOYU




