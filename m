From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC] [PATCH v3 2/4] OMAP4: Keyboard device registration
Date: Wed, 2 Jun 2010 15:46:03 +0200
Message-ID: <20100602154603.28fe7a16@surf>
References: <27F9C60D11D683428E133F85D2BB4A53043E537F74@dlee03.ent.ti.com>
	<20100602102813.59519b77@surf>
	<27F9C60D11D683428E133F85D2BB4A53043E538AA1@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.191.76.200]:51815 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab0FBNqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 09:46:11 -0400
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A53043E538AA1@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Arce, Abraham" <x0066660@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Wed, 2 Jun 2010 07:45:07 -0500
"Arce, Abraham" <x0066660@ti.com> wrote:

> I'll remove length variable and keep snprintf, below oh_name -> kbd is used again, this will keep name defined in one single place
> 
> 	WARN(IS_ERR(od), "Could not build omap_device for %s %s\n",
> 		name, oh_name);

In this case, why not:

	char *oh_name = "kbd";

There's really no point in using snprintf() for statically-defined
strings.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
