From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/4] omap mailbox: extend API to take a callback param
Date: Fri, 25 Jun 2010 16:20:24 +0300
Message-ID: <AANLkTinby3nM9OMMBPEjWohsrDlaolMpe1rEx2OrWdPS@mail.gmail.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4C890B4A@dlee03.ent.ti.com>
	<AANLkTinS1rPAEu-S-HOtslq7M1WeH3oCkPaeSh__8OIa@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4C8912F7@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56263 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404Ab0FYNUp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 09:20:45 -0400
Received: by wwi17 with SMTP id 17so1050822wwi.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 06:20:44 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4C8912F7@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

On Fri, Jun 25, 2010 at 3:52 AM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> I don't know what PCMIIW stands for :)

please correct me if I'm wrong :)


> It looks like the variable mbox_configured that was added previously doesn't cover all the issues. It covers the shutdown issue with reference counting but as you mentioned that it poses an issue at startup as the RX interrupt for the second mbox instance doesn't get enabled.


yeah.


> -- Even though this might not be relevant to mbox_configured issue, this looks like a nice feature to add. So this means we are going to support multiple writers to mailbox instance?


yes, multiple writers, but also it will allow multiple readers.
