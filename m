From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 1/4] Adding OMAP3 EVM support
Date: Thu, 24 Apr 2008 16:22:23 -0700
Message-ID: <87tzhqet3k.fsf@paris.hilman.org>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8F1B@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:64755 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762531AbYDXXWb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 19:22:31 -0400
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8F1B@dbde01.ent.ti.com> (Syed Mohammed's message of "Sat\, 19 Apr 2008 09\:01\:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org

Minor cosmetic suggestion...

As new files are added, can we please leave out full path to the file
in the file header?  Not only is this unnecessary clutter, after a
short amount of time, these are usually wrong as files get renamed,
reorganized etc. and the paths rarely get updated.

It's best to just leave them out.

Kevin

