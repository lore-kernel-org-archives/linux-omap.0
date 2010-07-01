From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Date: Thu, 01 Jul 2010 12:54:32 +0300
Message-ID: <1277978072.2474.283.camel@tubuntu.research.nokia.com>
References: <1277907327-3443-1-git-send-email-lazfamam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1277907327-3443-1-git-send-email-lazfamam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Afzal Mohammed <lazfamam@gmail.com>
Cc: "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, 2010-06-30 at 16:15 +0200, ext Afzal Mohammed wrote:
> If enabling fb0 fails in omapfb_create_framebuffers(), remove
> sysfs file before returning to probe. This is required to complete
> the cleanup in the above mentioned error case.

omapfb frees the resources in omapfb_free_resources(). I believe
removing sysfs should also be put into omapfb_free_resources() to be
consistent, and not as an explicit call like in this patch.

However, I'm not sure if some sysfs-allocated flag is needed for this to
work in all cases.

 Tomi
