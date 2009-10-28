From: Sergey Lapin <slapinid@gmail.com>
Subject: OMAP3 RFBI
Date: Wed, 28 Oct 2009 12:27:06 +0300
Message-ID: <48239d390910280227i6c48a11fw1422c7ddec11df45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:40739 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbZJ1J1C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 05:27:02 -0400
Received: by ewy4 with SMTP id 4so531320ewy.37
        for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 02:27:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, all!

I have LCD with external controller, which handles 176x220 LCD at
18bpp (666). This device has
8-bit interface and HX8340-B LCD controller. I have managed to make it
work using RFBI and send commands
using registers, manually. That works, except that it uses too much of
CPU to handle.
As I unerstand, "normal" operation mode of RFBI requires 16-bit
interface to controller,
but is it possible to accelerate device with system DMA? I only need
to accelerate data part (params register).
Commands are not too frequent here, only data streams are big.

Thanks a lot,
S.
