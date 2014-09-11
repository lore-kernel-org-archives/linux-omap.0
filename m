From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 2/2] Input: misc: introduce palmas-pwrbutton
Date: Thu, 11 Sep 2014 07:01:19 -0500
Message-ID: <20140911120119.GA17602@kahuna>
References: <1408392810-16011-1-git-send-email-nm@ti.com>
 <1408636935-29515-1-git-send-email-nm@ti.com>
 <1408636935-29515-3-git-send-email-nm@ti.com>
 <00FC9A978A94B7418C33AFAE8A35ED49DF0662@DFLE09.ent.ti.com>
 <53F62A2B.6010208@ti.com>
 <00FC9A978A94B7418C33AFAE8A35ED49DF07A2@DFLE09.ent.ti.com>
 <20140821173715.GA23419@kahuna>
 <20140821180300.GA5854@core.coreip.homeip.net>
 <53F64217.5020303@ti.com>
 <20140910211353.GE38736@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140910211353.GE38736@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Murphy, Dan" <dmurphy@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Dimtry,

On 14:13-20140910, Dmitry Torokhov wrote:
> On Thu, Aug 21, 2014 at 02:01:43PM -0500, Nishanth Menon wrote:
> > On 08/21/2014 01:03 PM, Dmitry Torokhov wrote:
> > 
> > I believe I have taken care of other concerns on v2, but..Arrgh.. I
> > did not reply to this comment..
> > > BTW, I do not think you need to use of_node_get/put here, it's not going anywhere.
> > It has been mentioned as a good practice to ensure we use get_put in
> > to ensure reference count is appropriately maintained. So, I have'nt
> > changed that in v3.
> 
> You only need to maintain reference count if you pass the handle on.
> Otherwise you'd have to do get/put every time you dereference something.
> 
> Anyway, I did a few changes to the driver (no need to store current
> state, do not fre einput device after unregister, etc.), could you
> please tell me if the version below still works for you?
[...]
Thanks for taking the time to do all the changes - they are awesome and
the resultant driver does work.

-- 
Regards,
Nishanth Menon
