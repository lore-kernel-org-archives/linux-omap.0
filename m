From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 13:45:56 +0200
Message-ID: <20101122114556.GD2446@legolas.emea.dhcp.ti.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
 <20101122111105.GZ2446@legolas.emea.dhcp.ti.com>
 <AANLkTikJfiJHnbBKWAfWn5xk2SOQiSAvHdjD0p78u4MA@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38267 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753434Ab0KVLpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 06:45:52 -0500
Received: by gxk25 with SMTP id 25so4349908gxk.36
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:45:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikJfiJHnbBKWAfWn5xk2SOQiSAvHdjD0p78u4MA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: balbi@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Mon, Nov 22, 2010 at 12:38:21PM +0100, Jean Pihet wrote:
>The original patch has the ti.com address in both the From: and
>Signed-off-by: fields, but the From: on the ML still shows otherwise.
>Weird...
>
>Any idea how to fix that?

how about setting sendemail.envelopesender ??

-- 
balbi
