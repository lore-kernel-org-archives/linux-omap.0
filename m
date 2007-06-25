From: Jukka Honkela <jukka@honkela.org>
Subject: Audio on H3
Date: Mon, 25 Jun 2007 14:29:00 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0706251407530.3089@ugly.blerp.org>
References: <OF896A6542.C7783F70-ON48257304.0082E604-48257304.00839ACF@accton.com.tw>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <OF896A6542.C7783F70-ON48257304.0082E604-48257304.00839ACF@accton.com.tw>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,

I've been trying to get omap1710 H3 board to produce
some audio (alsaplayer), but apparently I'm not doing
everything as expected.

I've been playing around with the latest kernels
and I've been using a hacked/cleaned up/recompiled
version of the basic maemo environment as userspace,
but so far my attempts to get anything played out
is not so good.

The problem is related at least to the dspgateway,
I get
MMU: OMAP mmu:dsp MMU initialized (HW v0.0)
Unable to handle kernel NULL pointer dereference at virtual address 
00000024
pgd = c16dc000
...

if I try to load the pcm2 module (from maemo) into the
dsp by using dspctl.

So, any hints how should I try to approach this problem,
I currently don't have even a proper /etc/alsa.conf ..
And, does anybody know how the dsp side of things goes,
where do the dspctl utility and the required DSP 
modules originally come from?

One interesting side-effect after building the audio
stuff into the kernel, the touch screen dies. The
current omap tree does not apparently even support the
touchscreen (tsc2101) but I managed to get it to
work by combining old sources with some tweaks into
them. But, as it is the very same chip that drives the
audio too, something apparently confuses the chip
or some related settings...

-- 
Jukka Honkela
