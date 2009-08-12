From: John Sarman <johnsarman@gmail.com>
Subject: Re: TI OMAP 3503 GPIO signal I/O standard for interfacing with FPGA
Date: Wed, 12 Aug 2009 08:54:06 -0400
Message-ID: <bb2708720908120554m33caeb32v4d13da69d1e94e7d@mail.gmail.com>
References: <BD5F061C-76EC-40EF-93D6-5C64860EBEA7@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f191.google.com ([209.85.211.191]:37602 "EHLO
	mail-yw0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbZHLMyG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:54:06 -0400
Received: by ywh29 with SMTP id 29so1133218ywh.33
        for <linux-omap@vger.kernel.org>; Wed, 12 Aug 2009 05:54:06 -0700 (PDT)
In-Reply-To: <BD5F061C-76EC-40EF-93D6-5C64860EBEA7@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Tue, Aug 11, 2009 at 3:12 PM, Elvis Dowson<elvis.dowson@mac.com> wro=
te:
> Hi,
> =A0 =A0 =A0 =A0If I have to interface the TI OMAP 3503 GPIO signals t=
o an FPGA
> (Xilinx Virtex-5), which I/O standard should I use.
Use LVCMOS at 1.8V  if you can not use 1.8 V (get another FPGA, just
kidding)  then you will need a buffer (level translator) between them.
 I had great success with
http://focus.ti.com/docs/prod/folders/print/txs0108e.html  (TXS0108)
8-channel push-pull/ open drain level transceiver.
John Sarman
>
> The options available to me for single ended I/O on the FPGA are : LV=
CMOS,
> LVTTL, HSTL, SSTL, GTL, PCI
>
> Best regards,
>
> Elvis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
