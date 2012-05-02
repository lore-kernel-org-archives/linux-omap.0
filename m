From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 0/2] OMAP: mailbox initial device tree support
Date: Wed, 2 May 2012 05:42:34 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "patches@linaro.org" <patches@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Omar,

On Tue, May 01, 2012 at 23:17:38, Omar Ramirez Luna wrote:
> To allow mailbox driver to function with device tree.
> 
> Tested in OMAP4 and OMAP3. OMAP2 untested.
>

I think the mailbox code needs a cleanup similar to what you
had proposed earlier [1] before the device tree support is added.

We probably need to decide whether the number of mailbox sub-modules
should be part of hwmod attribute or come from device tree. IMO the
static allocation of the mailboxes is better suited in the device-tree
data.

Regards,
Vaibhav

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/054582.html

