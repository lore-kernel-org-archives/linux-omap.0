From: Bryan Wu <bryan.wu@analog.com>
Subject: [Question] Can g_midi run on musb_gadget?
Date: Tue, 27 Nov 2007 12:04:25 +0800
Message-ID: <1196136265.7177.17.camel@roc-laptop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ben Williamson <ben.williamson@greyinnovation.com>, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi folks,

I am still testing and trying to enable some gadget drivers over
musb_gadget driver for Blackfin BF54x.

Does someone test g_midi over MUSB gadget driver?
Actually, current g_midi only supports full speed, then the MUSB gadget
will make g_midi usb_gadget_register_driver (in musb_gadget.c) function
call fail as below:
---
        if (!driver
                        || driver->speed != USB_SPEED_HIGH
                        || !driver->bind
                        || !driver->setup)
                return -EINVAL;
---

gmidi.c
---
static struct usb_gadget_driver gmidi_driver = {
        .speed          = USB_SPEED_FULL,
        .function       = (char *)longname,
        .bind           = gmidi_bind,
        .unbind         = gmidi_unbind,

        .setup          = gmidi_setup,
        .disconnect     = gmidi_disconnect,

        .suspend        = gmidi_suspend,
        .resume         = gmidi_resume,

        .driver         = {
                .name           = (char *)shortname,
                .owner          = THIS_MODULE,
        },
};
---

So I modified the musb_gadget.c to enable the g_midi.ko on my BF54x
hardware.

I got some question about the testing about the g_midi:

1. My Linux and Windows PC USB host can found the g_midi BF54x device,
for example:
---
roc@roc-laptop:~$ aplaymidi -l
 Port    Client name                      Port name
 14:0    Midi Through                     Midi Through Port-0
 20:0    MIDI Gadget                      MIDI Gadget MIDI 1
---

There is an ALSA AD1980 AC97 audio hardware and driver on BF54x and I am
sure it works well.
If I use "aplaymidi -p 20:0 ~/Desktop/onestop.mid" to try to play the
midi file over USB, can I heard sound from the AD1980 sound output port?
But I don't hear anything.

2. g_midi just provides an midi device, not a fully functional USB Audio
Class device, right?
Because some customer wanna enable the BF54x as USB Audio Class device
over musb_gadget driver.

3. Is there any URL or wiki about g_midi for developer as referrence?

Thanks a lot
-Bryan Wu
