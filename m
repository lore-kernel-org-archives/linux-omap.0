From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: OMAP3: enabling CPU idle leads to panic
Date: Fri, 27 Nov 2009 14:36:08 +0300
Message-ID: <48239d390911270336r37e3b127i409ea5927aa9c505@mail.gmail.com>
References: <48239d390911240713v50bcae9ek855fb1e07c081486@mail.gmail.com>
	 <873a43wzfm.fsf@deeprootsystems.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DD5AA0DC@dbde02.ent.ti.com>
	 <48239d390911250737q35fc602fu9bce0b0f96f6970d@mail.gmail.com>
	 <87iqcyh5p5.fsf@deeprootsystems.com>
	 <48239d390911270202s3f6fcdbchaa7053bace5c36@mail.gmail.com>
	 <48239d390911270248se826f84r84d6b42cbd69344@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9217@dbde02.ent.ti.com>
	 <48239d390911270332tdf05c1lb5014e56cd3aa18b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:44598 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbZK0LgD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 06:36:03 -0500
Received: by ewy19 with SMTP id 19so1313909ewy.21
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 03:36:09 -0800 (PST)
In-Reply-To: <48239d390911270332tdf05c1lb5014e56cd3aa18b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>
> Alas, that's not because omap_chip_is() function fails
> on these structures.
>

I mean during registration of power domains.
