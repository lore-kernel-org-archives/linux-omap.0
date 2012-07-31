From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm: refcnt drm_framebuffer
Date: Tue, 31 Jul 2012 18:00:08 +0100
Message-ID: <1343754016_22717@CP5-2952>
References: <1343751621-1868-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1343751621-1868-1-git-send-email-rob.clark@linaro.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Rob Clark <rob.clark@linaro.org>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, patches@linaro.org, Rob Clark <rob@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 31 Jul 2012 11:20:21 -0500, Rob Clark <rob.clark@linaro.org> wrote:
> From: Rob Clark <rob@ti.com>
> 
> This simplifies drm fb lifetime, and if the crtc/plane needs to hold
> a ref to the fb when disabling a pipe until the next vblank, this
> avoids the need to make disabling an overlay synchronous.  This is a
> problem that shows up when userspace is using a drm plane to
> implement a hw cursor.. making overlay disable synchronous causes
> a performance problem when x11 is rapidly enabling/disabling the
> hw cursor.  But not making it synchronous opens up a race condition
> for crashing if userspace turns around and immediately deletes the
> fb.  Refcnt'ing the fb makes it possible to solve this problem.

Presumably you have a follow-on patch putting the new refcnt to use so
that we can judge whether you truly need refcnting on the fb itself in
addition to the refcnted object and the various hw bookkeeping that
needs to be performed?
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
