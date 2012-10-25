From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC PATCH 4/6] ARM: OMAP: SmartReflex: provide SoC integration
 API for VP
Date: Thu, 25 Oct 2012 07:55:11 -0500
Message-ID: <20121025125510.GA22894@kahuna>
References: <1351028641-20832-1-git-send-email-nm@ti.com>
 <1351028641-20832-5-git-send-email-nm@ti.com>
 <CAORVsuWo0Gd1aBqtpJ7+S663a380kbM7jDbEaq37DGfCmEdFgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48633 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803Ab2JYMzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 08:55:12 -0400
Content-Disposition: inline
In-Reply-To: <CAORVsuWo0Gd1aBqtpJ7+S663a380kbM7jDbEaq37DGfCmEdFgA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: l-o <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, J Keerthy <j-keerthy@ti.com>

On 10:27-20121025, Jean Pihet wrote:
> On Tue, Oct 23, 2012 at 11:43 PM, Nishanth Menon <nm@ti.com> wrote:
[..]
> >  static int sr_class3_disable(struct omap_sr *sr, int is_volt_reset)
> >  {
> > +       if (!sr->soc_ops.vp_enable) {
> This should be ' if (!sr->soc_ops.vp_disbable) {'.
Argh.. yes. thanks for catching it. I will wait for any further comments
prior to reposting with the fix.
-- 
Regards,
Nishanth Menon
