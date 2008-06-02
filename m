From: "mohammed shareef" <mdshareef@gmail.com>
Subject: omap5912-osk bad magic number
Date: Mon, 2 Jun 2008 23:13:48 +0530
Message-ID: <a1d91fa0806021043n2c0c74b6j9dcbf02d3cc05b06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:52529 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYFBRnv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jun 2008 13:43:51 -0400
Received: by ti-out-0910.google.com with SMTP id b6so370679tic.23
        for <linux-omap@vger.kernel.org>; Mon, 02 Jun 2008 10:43:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi,

i tried to re-compile my kernel by adding a few features and then
transfered the new image using u-boot. Unfortunately am getting the
following error:

## Booting image at 00100000 ...
Bad Magic Number
OMAP5912 OSK #

The transfer seems to be complete and proper. all the environment
variables are also ok. i tried replacing the new image with the
previous working image. that also fails. could some one tell me whats
worng?

thank you,
Regards,
Shareef
