From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Camera: Update camera driver for correct
 use of API's
Date: Fri, 23 Nov 2007 13:09:08 +0200
Message-ID: <4746B4D4.1050605@nokia.com>
References: <1195663431-20390-1-git-send-email-edubezval@gmail.com>
	<1195663431-20390-2-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1195663431-20390-2-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> V4l2:
> - Updates this camera driver to use correctly the new videobuf API.
> Currently, changed to use videobuf_gen and videobuf_dma_sg.
> - Removed VIDEO_BUF reference from Kconfig.
> 
> S/G:
> - Update this code to sg_* helper functions.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Thanks for the patch, Eduardo!

I was actually preparing a fix but perhaps a bit late. I was waiting for 
the MUSB patch to make testing it a bit easier. ;)

There's one a bit subtle change in new videobuf code (?): 
videobuf_mmap_setup now returns the number of buffers instead of zero 
when it succeeds. (I ran into this...)

Cheers,

-- 
Sakari Ailus
sakari.ailus@nokia.com
