From: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH 00/14] Add support for FM radio in hcill and kill TI_ST
Date: Tue, 7 May 2019 13:34:00 -0500
Message-ID: <CAHCN7xLQ=h3bfwS=uTfjSpOtv9qWbic0=_51WJz9KmX7v8+vmw@mail.gmail.com>
References: <20181221011752.25627-1-sre@kernel.org> <4f47f7f2-3abb-856c-4db5-675caf8057c7@xs4all.nl>
 <20190319133154.7tbfafy7pguzw2tk@earth.universe> <CAHCN7xLZFLs=ed539bwuT6s-n6SDof-um7B3AeErQ2ChztC26A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7xLZFLs=ed539bwuT6s-n6SDof-um7B3AeErQ2ChztC26A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-media@vger.kernel.org, Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, May 7, 2019 at 12:26 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Mar 19, 2019 at 8:33 AM Sebastian Reichel <sre@kernel.org> wrote:
> >
> > Hi Hans,
> >
> > On Thu, Mar 14, 2019 at 09:20:10AM +0100, Hans Verkuil wrote:
> > > On 12/21/18 2:17 AM, Sebastian Reichel wrote:
> > > > This moves all remaining users of the legacy TI_ST driver to hcill (patches
> > > > 1-3). Then patches 4-7 convert wl128x-radio driver to a standard platform
> > > > device driver with support for multiple instances. Patch 7 will result in
> > > > (userless) TI_ST driver no longer supporting radio at runtime. Patch 8-11 do
> > > > some cleanups in the wl128x-radio driver. Finally patch 12 removes the TI_ST
> > > > specific parts from wl128x-radio and adds the required infrastructure to use it
> > > > with the serdev hcill driver instead. The remaining patches 13 and 14 remove
> > > > the old TI_ST code.
> > > >
> > > > The new code has been tested on the Motorola Droid 4. For testing the audio
> > > > should be configured to route Ext to Speaker or Headphone. Then you need to
> > > > plug headphone, since its cable is used as antenna. For testing there is a
> > > > 'radio' utility packages in Debian. When you start the utility you need to
> > > > specify a frequency, since initial get_frequency returns an error:
> > >
> > > What is the status of this series?
> > >
> > > Based on some of the replies (from Adam Ford in particular) it appears that
> > > this isn't ready to be merged, so is a v2 planned?
> >
> > Yes, a v2 is planned, but I'm super busy at the moment. I don't
> > expect to send something for this merge window. Neither LogicPD
> > nor IGEP use FM radio, so I can just remove FM support from the
> > TI_ST framework. Converting those platforms to hci_ll can be done
> > in a different patchset.
> >
> > If that was the only issue there would be a v2 already. But Marcel
> > Holtmann suggested to pass the custom packet data through the BT
> > subsystem, which is non-trivial (at least for me) :)
>
> I am running some tests today on the wl1283-st on the Logic PD Torpedo
> board.  Tony had suggested a few options, so I'm going to try those.
> Looking at those today.  If/when you have a V2, please CC me on it. If
> it's been posted, can you send me a link?  I would really like to see
> the st-kim driver go away so I'd like to resolve the issues with the
> torpedo board.

I have run a bunch of tests on the 5.1 kernel.  I am able to get the
firmware to load now and the hci0 goes up.  I was able to establish a
BLE connection to a TI Sensor Tag and read and write data to it with
good success on the wl1283.

Unfortunately, when I tried to do some more extensive testing over
classic Bluetooth, I got an error that repeats itself at seemingly
random intervals:
      Bluetooth: hci0: Frame reassembly failed (-84)

I can still scan and pair, but these Frame reassembly failed errors
appear to come and go.

Do we need to do anything to enable hardware handshaking?  In the
older st-kim driver, the pdata structure listed flow_cntrl=1.  The
i.MX boards use "uart-has-rtscts" in their device trees, but I don't
see anything like that for the omap3-uart driver.  I am not all that
familiar with the Bluetooth subsystem, so I am not sure what would
cause the Frame reassembly error.

adam
>
> thanks
>
> adam
> >
> > -- Sebastian
