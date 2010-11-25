From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12]  media: Entities,
 pads and links
Date: Thu, 25 Nov 2010 15:35:46 +0000
Message-ID: <20101125153546.GI22298@rakim.wolfsonmicro.main>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<4CEE2E7D.6060608@ladisch.de>
	<20101125134135.GB24208@opensource.wolfsonmicro.com>
	<201011251629.54575.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201011251629.54575.laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, sakari.ailus@maxwell.research.nokia.com, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, lennart@poettering.net, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 04:29:53PM +0100, Laurent Pinchart wrote:

> It depends on how you define nodes. I can certainly imagine a graph with 100 
> controls, but maybe several controls can be part of the same node ? On the 
> video side we've decided to split entities depending on the possible data 
> paths configurations. As I'm not a fluent ascii-art speaker, please have a 
> look at pages 4 and 5 of http://www.ideasonboard.org/media/20101103-lpc-
> media.pdf

Please take a look at:

	http://www.wolfsonmicro.com/products/WM8994

for an example of a modern smartphone CODEC.  This has in the ballpark
of 75-100 nodes (I've not counted exactly) represented in the routing
graph in the driver today.  This does not include any audio routing
available in other components such as the CPU.
