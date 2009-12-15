From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/3] musb: save dynfifo in musb struct
Date: Tue, 15 Dec 2009 10:32:36 +0200
Message-ID: <20091215083236.GL12526@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <20091214162454.GA31829@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAD03@dbde02.ent.ti.com>
 <20091215072650.GA3147@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAE01@dbde02.ent.ti.com>
 <20091215074025.GB3147@nokia.com>
 <19F8576C6E063C45BE387C64729E739404372AAE06@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29649 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbZLOIdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 03:33:20 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404372AAE06@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>

Hi,

On Tue, Dec 15, 2009 at 08:44:56AM +0100, ext Gupta, Ajay Kumar wrote:
>Another point, BlackFin doesn't have CONFIGDATA register and it always
>Returns '0' from it's custom function musb_read_configdata().
>
>As it returns '0' and also BlackFin doesn't support Dynamic FIFO so
>Should be fine.
>
>Any comment ?

yeah, should be fine.

-- 
balbi
