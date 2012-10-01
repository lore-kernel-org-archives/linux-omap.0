From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 1/4] mfd: smsc: Add support for smsc gpio io/keypad
 driver
Date: Mon, 1 Oct 2012 12:44:54 +0100
Message-ID: <20121001114454.GA9170@sirena.org.uk>
References: <1349089282-22105-1-git-send-email-sourav.poddar@ti.com>
 <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAe_U6+zEGuwMC1yn7O=LXE6PhPvPc2i7DCF0EAprkE8s+-iEw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: "ABRAHAM, KISHON VIJAY" <kishon@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, b-cousson@ti.com, balbi@ti.com, santosh.shilimkar@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 01, 2012 at 05:00:06PM +0530, ABRAHAM, KISHON VIJAY wrote:
> On Mon, Oct 1, 2012 at 4:31 PM, Sourav Poddar <sourav.poddar@ti.com> wrote:

Delete irrelevant context from your replies, it makes it much easier to
find new text.

> > +static int smsc_i2c_remove(struct i2c_client *i2c)
> > +{
> > +       struct smsc *smsc = i2c_get_clientdata(i2c);
> > +
> > +       mfd_remove_devices(smsc->dev);

> IMO, this should have resulted in an abort (hint: see
> mfd_remove_devices_fn()). Trying to do mfd_remove_devices without
> mfd_add_devices(). Use device_for_each_child here to remove the
> device.

No, this is not at all sensible - if there's an mfd_remove_devices()
function we really ought to be able to use it to remove the children.
If we can't do that we should fix the API usability, not open code the
same stuff in every user.
