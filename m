From: "Gross, Andy" <andy.gross@ti.com>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 24 May 2012 10:09:38 -0500
Message-ID: <CABT81PhhCaXuHW+x34_Q8izdcW0Ud8dNVSMEr0Zzyt9FAjm5TA@mail.gmail.com>
References: <1337803690-30116-1-git-send-email-andy.gross@ti.com>
	<1337839294.2764.7.camel@lappyti>
	<CAO8GWq=rGLw3nx_r3+AO6xZNSDVyftpUXwWnbfevga4x2QUxfA@mail.gmail.com>
	<1337843144.2909.17.camel@deskari>
	<1337844098.2909.20.camel@deskari>
	<CAF6AEGur-mmZDVrE+Y-6tesNCVKp4xKKuS-C7ozTSJ2KQijHdw@mail.gmail.com>
	<1337861581.12304.7.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1337861581.12304.7.camel@deskari>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: greg@kroah.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Clark <rob.clark@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thu, May 24, 2012 at 7:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wro=
te:
> On Thu, 2012-05-24 at 02:44 -0600, Rob Clark wrote:
>
>> but other drivers *can* use tiler, thanks to dmabuf.. I have omap4iss
>> v4l2 camera working w/ tiler buffers on my pandaboard, for example.
>>
>> Maybe fbdev is an exception to the rule because it has no way for
>> userspace to pass it a buffer to use. =A0But on the other hand it is a
>> legacy API so I'm not sure if it is worth loosing too much sleep over
>> that.
>
> I'm not that familiar with dmabuf, but are you saying it's not possible
> for a kernel driver to request the buffers? They _must_ come from the
> userspace?
>
> Anyway, even if it would be possible, if the tiler is a part of omapdrm
> we need omapdrm to get and use the tiler buffers. And we can't have
> omapdrm running when using omapfb, because they both use omapdss.

And that is a good point.  The DSS is kind of a sticking point to anyone
having to enable DRM to get Tiler.  However, omapfb doesn't currently utili=
ze
DMM/Tiler features.  Can't we defer generalizing until there is a
requirement for it?

Andy
