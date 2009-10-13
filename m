From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: New project announcement: gst-dsp, with beagleboard
 demo image
Date: Tue, 13 Oct 2009 12:49:57 +0300
Message-ID: <94a0d4530910130249w10e490e9y96a173cf36926660@mail.gmail.com>
References: <94a0d4530910121431r4f0e6d3dw2b87d22adc393842@mail.gmail.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <grbounce-mhDLDAUAAACCWz0gcxlWH96hoF08oTo0=gchbu-beagleboard=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <94a0d4530910121431r4f0e6d3dw2b87d22adc393842-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/beagleboard/subscribe>,
	<mailto:beagleboard+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: gstreamer-openmax-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gstreamer-embedded-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, maemo-developers-41UWDLvetLrYtjvyW6yDsg@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openmax-devel-8+VKa2cMCdNg9hUCZPvPmw@public.gmane.org, =?UTF-8?B?RXJheSDDlnp0w7xyaw==?= <erayozturk1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Kang <paulchainkang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregoire Gentil <gregoire-cO8BdTktXKTQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On Tue, Oct 13, 2009 at 12:31 AM, Felipe Contreras
<felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> This is the first public release of gst-dsp; a native GStreamer plug-in to
> access Texas Instruments' DSP algorithms for OMAP3 platforms.
>
> The code came originally from a series of TI projects: tiopenmax[1], and
> libbridge[2]. gst-dsp replaces these two layers and talks directly to the DSP
> bridge driver.
>
> The main advantages are code simplification (5k vs 50k), and better performance
> (at least 4 times less CPU usage). However, not all of the codecs have been
> implemented, only MPEG-4 and H.263 video encoders and decoders, the JPEG
> encoder, and H.264 is partially supported.
>
> Currently it's used in the Nokia N900.
>
> In order to make it easier for people to try it out, I created a demo image for
> the beagleboard with all the required components: GStreamer, gst-dsp, DSP
> public binaries, and a kernel with DSS2 and DSP bridge driver.
>
> The linux kernel (DSS2 + dspbridge) is at the v2.6.32-felipec1 tag in:
> http://gitorious.org/~felipec/linux-omap/felipec
>
> The DSP algorithms are public, and come from tiopenmax:
> https://gforge.ti.com/gf/download/frsrelease/170/1399/tiopenmax-0.3.5.tar.gz
>
> Here's the demo rootfs with the kernel image and instructions:
> http://people.freedesktop.org/~felipec/beagle-2.6.32-rc3/
>
> And here's the video showing it on action for both playback and recording:
> http://www.youtube.com/watch?v=SN-Nw_yDQUs

I removed the video because of a bug in YouTube and uploaded it again:
http://www.youtube.com/watch?v=CjxkNIHBGdI

Cheers.

-- 
Felipe Contreras
