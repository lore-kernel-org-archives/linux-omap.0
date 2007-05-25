From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH] OMAP: 2430SDP: Support LCD display as a FB device
Date: Fri, 25 May 2007 15:43:44 -0700
Message-ID: <465766A0.8020105@mvista.com>
References: <200705251518.13137.hyau@mvista.com>	<20070525223324.GF21314@atomide.com>
	<782515bb0705251536g5d3bb24dw419df48535fc9082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <782515bb0705251536g5d3bb24dw419df48535fc9082@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nishanth menon <menon.nishanth@gmail.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

nishanth menon wrote:
> Tony,
> 
> On 5/25/07, Tony Lindgren <tony@atomide.com> wrote:
>> * Hunyue Yau <hyau@mvista.com> [070525 15:19]:
>> > Add glue to control the 2430SDP LCD as a frame buffer device
>> > using the existing dispc.c driver under omapfb.
>>
>> Thanks, pushing today.
> Why are we having so many board-2430sdp variants? we now have
> arch/arm/mach-omap2/board-2430sdp.c
> arch/arm/mach-omap2/board-2430sdp-flash.c
> arch/arm/mach-omap2/board-2430sdp-usb.c. Now one more... cant we plug
> these 100 liner codes into board-2430sdp.c?

Hmm, the display changes were indeed added to board-2430.c, not to anthoer new file.

Personally, I think the multiple board files are easier to read, and cleaner.  Did you notice all the board-n800* files?

Kevin
