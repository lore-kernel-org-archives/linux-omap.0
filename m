From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv5] Input: keypad: Add smsc ece1099 keypad driver
Date: Mon, 29 Oct 2012 13:45:20 -0700
Message-ID: <20121029204520.GC13256@core.coreip.homeip.net>
References: <1351507129-10229-1-git-send-email-sourav.poddar@ti.com>
 <20121029162045.GK27566@arwen.pp.htv.fi>
 <20121029170633.GA11558@core.coreip.homeip.net>
 <20121029190516.GA29230@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121029190516.GA29230-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 29, 2012 at 09:05:53PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Oct 29, 2012 at 10:06:33AM -0700, Dmitry Torokhov wrote:
> 
> [ big snip ]
> 
> > > > +static int __devexit smsc_remove(struct platform_device *pdev)
> > > > +{
> > > 
> > > shouldn't you unregister the input device here ??
> > 
> > And that is why I do not like devm_* interface myself... But no, since
> > input device was allocated with devm_input_allocate_device() it does not
> > need to be explicitly freed or unregistered.
> 
> IMHO, that's a fragility on current devm implementation for input
> devices, then.
> 
> devm_input_allocate_device() is *only* allocating the input device (at
> least judging by the name). Looks like you should introduce
> devm_input_register_device() ? What happens if I
> devm_input_allocate_device() but don't go as far as
> input_register_device() (some error happens in-between) ?
> 

It will be freed automatically.

> I'm sure you have some proper handling for it, but it's quite misleading
> the way this was implemented.

Well, I could add devm_input_register_device(),
devm_input_unregister_device(), devm_input_free_device() and then add
checks to "normal" input_register_device(), input_unregister_device()
and input_free_device() to throw warnings and errors if they are used
with managed resources, and similarly add checks to devm_* API so that
they are not called with unmanaged devices and make a big mess out of
it.

_OR_ I could just add one new call devm_input_allocate_device() to
create managed input devices and make the rest of old API work with both
managed and unmanaged input devices. I think the latter is much better.

Thanks.

-- 
Dmitry
