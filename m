From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: RE: undefined instruction
Date: Wed, 25 Jun 2008 11:22:12 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A8708CFE66C@dlee01.ent.ti.com>
References: <a1d91fa0806250029x2bf114f5t2f45bb1472e96fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:51098 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbYFYQWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 12:22:22 -0400
In-Reply-To: <a1d91fa0806250029x2bf114f5t2f45bb1472e96fbb@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>, omap <linux-omap@vger.kernel.org>

> then i changed the filename and the
> tftpboot transfer started. But on the mid-way it complains  "undefined
> instruction".
>
> could some one please tell me where the problem is? thank you.


How big is the file that you are attempting to download over tftp?

U-boot executes in the upper part of the RAM and so if your file is too big, then there is a good chance you are overwriting u-boot which would cause u-boot to crash eventually. U-boot does not protect against this. This would be a potential cause of an undefined instruction exception.

Jon
