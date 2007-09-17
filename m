From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Add OmniVision ov9640 sensor driver with new
	v4l2 interface.
Date: Mon, 17 Sep 2007 11:33:39 -0700
Message-ID: <20070917183338.GI21226@atomide.com>
References: <5d5443650709060541q5112eb7ei5132efbcc6be7d13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650709060541q5112eb7ei5132efbcc6be7d13@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Sakari Ailus <sakari.ailus@nokia.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070906 05:44]:
> Hi All,
> 
> Copying the commit message:
> 
> -------------------------------snip-----------------------
> Subject: [PATCH] OMAP: Add OmniVision ov9640 sensor driver with new
> v4l2 interface.
> 
> - Add OmniVision ov9640 sensor driver with new I2C style bindings,
>   converted to use new v4l2 sensor interface and moved
>   platform specific data to board files.
> 
> - Sensor used with H4 omap2420 doesn't give the correct capture
>   output and need to be investigated.
> 
> - Sensor detection works.
> -------------------------------snip-------------------------
> 
> So, it would be great if people having H4 can test and report the
> problem we might have in existing sensor/camera controller driver to
> get the correct capture output. Thanx.
> 
> Please not that this driver is added in "drivers/media/video"
> directory instead of the "omap" one, as we are not planning to take
> extra directory to upstream for camera.

Pushing this too. Are there files under drivers/media/video/omap that
we can remove now?

Regards,

Tony
