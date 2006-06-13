From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP 5912OSK and touchscreen under Qt/Embedded
Date: Tue, 13 Jun 2006 16:48:11 +0200
Message-ID: <448ED02B.1060209@gmail.com>
References: <CA21EAA4DF189C40A3BC30A5A75DA56001D4C846@ratatosk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <CA21EAA4DF189C40A3BC30A5A75DA56001D4C846@ratatosk>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Birger Kroon <Birger.Kroon@sys.teleca.se>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Birger Kroon wrote:
> Does anyone here have experience of getting a touchscreen working with Qt/embedded?
>  
> * I'm currently using the OMAP 5912OSK with the Mistral LCD unit.
> * I've got Qt/Embedded up and running on the platform (at least the display). 
> * I'm using the latest kernel/patch.
> * I see events when I touch the screen so the low level drivers does work correct I beleive.
>  
> My problem is that I do not know how to connect Qt/E with the touch screen drivers in the correct way. I've testet to set the 'QWS_MOUSE_PROTO' environment variable to different thing, but w/o success. 
> 
> - Do I need the tslib to use a TS under Qt/E? 

Yes, you should use tslib for QT/E. Do calibration first 
with tslib and then start QT/E.

Note that OMAP5912 touchscreen is broken in recent git. If 
you use recent git, you should apply

http://linux.omap.com/pipermail/linux-omap-open-source/2006-June/007358.html

as well.

However, latest patch on http://www.muru.com/linux/omap/ 
should be okay (?).

Try to use -tslib to configure QT/E . If I remember 
correctly there is a macro QT_QWS_TSLIB available within QT/E.

Maybe ask google as well.

Hth,

dirk
