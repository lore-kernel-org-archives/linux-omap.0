From: Sergey Lapin <slapinid@gmail.com>
Subject: PM branch
Date: Mon, 14 Dec 2009 15:11:45 +0300
Message-ID: <48239d390912140411u389116c3oc557eb7a51b5e192@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50957 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095AbZLNMLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 07:11:46 -0500
Received: by ewy19 with SMTP id 19so3286030ewy.21
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 04:11:45 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, all!

I have some weird behavior with old RFBI (old, non-DSS2) driver on PM
branch (actually upgraded from 2.6.28).
I use PM branch as my code base. I'd like to try to disable PM stuff
to check if that triggers it (RFBI
interrupt stop coming accidentally after some time, and whole video hang).
But when I change PM from SRF to PM I can't make device to work,
console stops recieving
characters, and video stops working at all. What configuration should
I have to make my device work without PM?

Thanks a lot,
S.
