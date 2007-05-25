From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: [PATCH] OMAP: 2430SDP: Support LCD display as a FB device
Date: Fri, 25 May 2007 17:36:27 -0500
Message-ID: <782515bb0705251536g5d3bb24dw419df48535fc9082@mail.gmail.com>
References: <200705251518.13137.hyau@mvista.com>
	<20070525223324.GF21314@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070525223324.GF21314@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony,

On 5/25/07, Tony Lindgren <tony@atomide.com> wrote:
> * Hunyue Yau <hyau@mvista.com> [070525 15:19]:
> > Add glue to control the 2430SDP LCD as a frame buffer device
> > using the existing dispc.c driver under omapfb.
>
> Thanks, pushing today.
Why are we having so many board-2430sdp variants? we now have
arch/arm/mach-omap2/board-2430sdp.c
arch/arm/mach-omap2/board-2430sdp-flash.c
arch/arm/mach-omap2/board-2430sdp-usb.c. Now one more... cant we plug
these 100 liner codes into board-2430sdp.c?
Regards,
Nishanth Menon
