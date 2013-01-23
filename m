From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/4] drm/tilcdc: add TI LCD Controller DRM driver (v3)
Date: Wed, 23 Jan 2013 08:37:34 -0600
Message-ID: <CAF6AEGtX3Z7ZU0=DsmqnVSHng8gXZZ7=ExYJ+zhFXad9pUjVig@mail.gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
 <1358894185-21617-2-git-send-email-robdclark@gmail.com>
 <20130123104216.1de2eee1@armhf>
 <CAF6AEGsDq8AW1-8uYmgc7DNvVU-eF=emWw24nTDHWBMwM_wUDA@mail.gmail.com>
 <20130123133607.GE2637@n2100.arm.linux.org.uk>
 <CAF6AEGu2f_zqkKayS-7ZEiVHHEhEYcqE2eL2BQ4rxW6+08wm7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAF6AEGu2f_zqkKayS-7ZEiVHHEhEYcqE2eL2BQ4rxW6+08wm7w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 23, 2013 at 8:13 AM, Rob Clark <robdclark@gmail.com> wrote:
> On Wed, Jan 23, 2013 at 7:36 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Jan 23, 2013 at 07:24:33AM -0600, Rob Clark wrote:
>>> On Wed, Jan 23, 2013 at 3:42 AM, Jean-Francois Moine <moinejf@free.fr> wrote:
>>> > Hi Rob,
>>> >
>>> > As I wanted to re-use your nxp-tda998x driver for the Marvell Dove SoC,
>>> > I had a look at your IT LCD driver. Comments below.
>>>
>>> Just fyi, you can re-use the nxp-tda998x part independently of tilcdc
>>> (just in case that wasn't clear).
>>
>> Great, this chip is also used on the cubox too.
>
> cool, it would be great if other platforms could benefit from this as
> well.. the out-of-tree nxp driver is just horrid ;-)
>
>> The one thing I wonder is how you deal with the VSYNC/HSYNC polarities
>> that are provided to the TDA9988x chip.  On the cubox, I have to adjust
>> the mode parameters such that the polarities are fixed up thusly:
>>
>>         adjusted->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC |
>>                              DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC |
>>                              DRM_MODE_FLAG_PCSYNC | DRM_MODE_FLAG_NCSYNC);
>>
>>         /* The TDA19988 always requires negative VSYNC? */
>>         adjusted->flags |= DRM_MODE_FLAG_NVSYNC;
>>
>>         /* The TDA19988 requires positive HSYNC on 1080p or 720p */
>>         if ((adjusted->hdisplay == 1920 && adjusted->vdisplay == 1080) ||
>>             (adjusted->hdisplay == 1280 && adjusted->vdisplay == 720))
>>                 adjusted->flags |= DRM_MODE_FLAG_PHSYNC;
>>         else
>>                 adjusted->flags |= DRM_MODE_FLAG_NHSYNC;
>>
>>         return true;
>>
>> for these resolutions to be displayed correctly.
>
> hmm, I didn't come across this.  Although 1080p seems to be a bit more
> than what the little board I'm working on can drive.  I didn't have to
> do any special fixup for 720p..

one thought.. I haven't enabled any hdmi features like audio yet..
which could be a reason that I didn't hit some of these issues.  I'm
not really much of an audio/asoc expert so I'm not really sure how
this should hook in for audio stuff, but if someone out there with
some hw with a similar nxp encoder chip does have some better audio
experience, I'd be interested to work together on that.

BR,
-R

> I wonder if you are having to do that with the nxp out of tree driver?
>  Maybe it is related to how that driver it is configuring the hw?  It
> would be interesting if you hit the same issue w/ the i2c encoder
> slave version.
>
> At any rate, if it turns out to be needed, we can add this in
> tda998x_encoder_mode_fixup().
>
>> Also, when the only output is the HDMI device, reporting the display
>> "disconnected" and without any modes seems to cause problems - I have to
>> report "unknown" status when there's nothing connected, and also provide
>> a default (720p) mode when no EDID is received.
>
> hmm, also did not run into any issues here on my end.  What sort of
> problems did you hit?
>
> BR,
> -R
