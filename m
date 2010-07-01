From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Date: Thu, 01 Jul 2010 17:57:18 +0300
Message-ID: <1277996239.2474.354.camel@tubuntu.research.nokia.com>
References: <1277991601-16528-1-git-send-email-lazfamam@gmail.com>
	 <1277991601-16528-2-git-send-email-lazfamam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277991601-16528-2-git-send-email-lazfamam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Afzal Mohammed <lazfamam@gmail.com>
Cc: "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2010-07-01 at 15:40 +0200, ext Afzal Mohammed wrote:
> Move sysfs entry creation to omapfb_probe() from omapfb_create_framebuffers().
> This will make sure that sysfs entry is not left behind in case of unsuccessful
> probe due to failure in enabling fb0 of omapfb_create_framebuffers().

Yes, I think this version is ok. Thanks!

 Tomi
