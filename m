From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] camera: c99 style structure
Date: Mon, 21 Nov 2005 09:52:31 -0800
Message-ID: <20051121175231.GB7680@atomide.com>
References: <304D2A85A9643F4A991BDDF8D297BBA60181A12C@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA60181A12C@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Zhang, Jian <jzhang@ti.com> [051121 07:20]:
> Komal,
> 
> omap16xxcam.c is an OMAP specific file (OMAP1 camera I/F) instead of
> board specific file. I like to keep omap16xxcam.c both board and sensor
> independent. My suggestion is that moving the board code from the ov9640
> sensor driver to board files and calling the board functions from the
> sensor. So the sensor interface is intact.

I like this too.
 
> From: Komal Shah [mailto:komal_shah802003@yahoo.com] 
> 
> I have attached the patch to update the structures in 16xxcam.c and
> sensor file to c99 way and fixes compilation of drivers on h3.

I'll push this one today.

Tony
