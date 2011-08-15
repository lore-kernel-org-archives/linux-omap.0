From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
Subject: wakelock in TI OMAP usb adb driver
Date: Mon, 15 Aug 2011 15:11:29 +0800
Message-ID: <CAORxB+Bij5HkjJtK95vusNdF9YJkrn0rmhXby9XaWE_XAgMO2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:47804 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1HOHL3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Aug 2011 03:11:29 -0400
Received: by pzk37 with SMTP id 37so2493578pzk.1
        for <linux-omap@vger.kernel.org>; Mon, 15 Aug 2011 00:11:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: android-kernel@googlegroups.com, linux-omap@vger.kernel.org

Hi All,
    I found the TI OMAP usb adb driver does not acquire a wake lock or
timeout wake lock, so the adb connection will be broken when system
enter suspend mode. Even if enabled the option in Android 'Stay
awake', the system will also break the adb connection.
Is it a bug or something else? Thanks.

BRs,
Lei Bian
