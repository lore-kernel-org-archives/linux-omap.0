From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v6 04/10] omap2: Fix camera resources for multiomap
Date: Mon, 14 Feb 2011 17:11:05 +0200
Message-ID: <AANLkTin-vJuDUWeMOpQktnkHgTTXGxqm4+se1p90y1YT@mail.gmail.com>
References: <1297686097-9804-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201102141419.24953.laurent.pinchart@ideasonboard.com>
	<20110214134116.GG2549@legolas.emea.dhcp.ti.com>
	<201102141450.31975.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201102141450.31975.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: balbi@ti.com, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 14, 2011 at 3:50 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Felipe,

Hello,

>
> On Monday 14 February 2011 14:41:16 Felipe Balbi wrote:
>> On Mon, Feb 14, 2011 at 02:19:24PM +0100, Laurent Pinchart wrote:
>> > On Monday 14 February 2011 13:35:59 Felipe Balbi wrote:
>> > > On Mon, Feb 14, 2011 at 01:21:31PM +0100, Laurent Pinchart wrote=
:
>> > > > diff --git a/arch/arm/mach-omap2/devices.c
>> > > > b/arch/arm/mach-omap2/devices.c index 4cf48ea..5d844bd 100644
>> > > > --- a/arch/arm/mach-omap2/devices.c
>> > > > +++ b/arch/arm/mach-omap2/devices.c
>> > > > @@ -38,7 +38,7 @@
>> > > >
>> > > > =C2=A0#if defined(CONFIG_VIDEO_OMAP2) ||
>> > > > =C2=A0defined(CONFIG_VIDEO_OMAP2_MODULE)
>> > > >
>> > > > -static struct resource cam_resources[] =3D {
>> > > > +static struct resource omap2cam_resources[] =3D {
>> > >
>> > > should this be __initdata ??
>> >
>> > The resources will be used when the OMAP3 ISP module is loaded. Wo=
n't
>> > they be discared if marked as __initdata ?
>>
>> I believe driver core makes a copy of those, no ? not sure.
>
> Not that I know of, but I may be wrong.

I don't think omap2cam_resources would be used at all.
AFAIK, it belongs to omap2xxcam, isn't it? :)

Br,

David
