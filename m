From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: [PATCH] omap camera
Date: Sat, 11 Feb 2006 08:34:17 +0200
Message-ID: <20060211063417.GB15109@nokia.com>
References: <43ECFF9B.80509@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43ECFF9B.80509@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Cohen <david.cohen@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 10, 2006 at 05:03:23PM -0400, David Cohen wrote:
> I don't think it is appropriate to use a common driver (camera_core) for
> the omap 2420 and 1611/1710. I guess creating a common driver for omap1
> (current camera_core) and other for omap2 (an updated camera_core) could
> be better. Any comment?

Perhaps you can explain a little more why you feel it's inappropriate for
omap1 and omap2 to share the same camera_core?

Also, why is this driver doing its own scatter-gather processing rather
than working with the DMA mapping API?

Plans for actually doing something wih the MMU?
