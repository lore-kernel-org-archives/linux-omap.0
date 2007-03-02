From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] ARM: OMAP2: Camera: Adapt to 2.6.20.
Date: Fri, 02 Mar 2007 13:49:03 +0200
Message-ID: <45E80F2F.8060008@nokia.com>
References: <45E5A489.2040108@nokia.com>	
	<11726783562347-git-send-email-sakari.ailus@nokia.com>	
	<11726783562842-git-send-email-sakari.ailus@nokia.com>	
	<11726783561918-git-send-email-sakari.ailus@nokia.com>	
	<1172678356543-git-send-email-sakari.ailus@nokia.com>
	<5d5443650702282128v6d3e7ab6jff886249e300db6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650702282128v6d3e7ab6jff886249e300db6e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Trilok Soni wrote:
> I think you have not looked at patches posted by me about OMAP2420
> camera. Part of the changes are taken from N800 kernel tree and TI's
> tree. Those sensor interface changes are also changed to adapt TI
> Micron sensor. I believe you should have worked on those changes and
> modified sensor interface for N800. Why re-work?

I was actually thinking of that sensor interface change due to Micron 
sensor (in your patches) a bit. Anyway, as I said, this is a work in 
progress, and I've been just trying to keep the driver somehow functional.

I don't like the original sensor interface very much. It passes void 
pointers with no name to interface functions, these pointers obviously 
point to some sensor private data. Then the init function returns the 
pointer to the sensor. Hmm.

I'd like that the sensor didn't know about the camera. This is 
accomplished by adding a generic camera interface with register, reset 
(so far specific to N800) and unregister. The sensor could then register 
itself to the camera, whose pointer it gets from its configuration 
(machine specific).

module field has been added so that the camera can try_module_get() the 
sensor when the device is opened. Beyond that it's just what I see fit. 
:) This is all naturally open for changes.

> http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009062.html 
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009063.html 
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009069.html 
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009064.html 
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009065.html 
> 
> 
> Please help me to review above patches instead, then we will have less
> re-work and come to conclusion, whose patches should be integrated
> instead. BTW, I have N800 so I can test this sensor now.

I'll have a look.

-- 
Sakari Ailus
sakari.ailus@nokia.com
