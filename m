From: Belisko Marek <marek.belisko@gmail.com>
Subject: No device for DAI omap-eac-dai error
Date: Fri, 18 Dec 2009 15:18:43 +0100
Message-ID: <e7c6a05e0912180618h771b9b7fl9d197d500bc534c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:34657 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbZLROSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 09:18:45 -0500
Received: by iwn1 with SMTP id 1so2179427iwn.33
        for <linux-omap@vger.kernel.org>; Fri, 18 Dec 2009 06:18:43 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm writing new omap dai (for EAC codec base omap's).
My code is based on existing omap-mcbsp.c code basically.

After loadingof module I got error which appear in init function when
call snd_soc_register_dai().

I browse for code but can't figure out where dai->dev should be set to
don't get error message and init dai properly.

Thanks for any suggestions

Marek
