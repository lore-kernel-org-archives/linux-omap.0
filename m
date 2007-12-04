From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: Re: MEASURING CURRENT DRAWN BY OMAP5912
Date: Tue, 4 Dec 2007 10:02:40 -0400
Message-ID: <20071204140240.GF6636@1BRL00624.americas.nokia.com>
References: <6ED95C184239FC419DFE88BA479737655DF863DF@mailnt.doble.com>
Reply-To: ext-felipe.lima@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <6ED95C184239FC419DFE88BA479737655DF863DF@mailnt.doble.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Grubner, Martin" <mgrubner@doble.com>
Cc: ext-felipe.lima@nokia.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 04, 2007 at 08:58:24AM -0500, ext Grubner, Martin wrote:
> 
> Felipe,
> The spectrum digital eval board OSK5912 has 1 ohm resistors on each of the OMAP power rails. This allows for taking current measurement data for each rail. The user's manual on their website has some more info on current and how to calculate it. Look at
> http://omap.spectrumdigital.com/osk5912/
> 

Hmm.. didn't know about it. Good to know they already have shunt
resistors in it. And if it's 1 ohm resistor the current will be
(approx.) the same as the voltage drop on that resistor.

> 
> -----Original Message-----
> From:	linux-omap-open-source-bounces@linux.omap.com on behalf of Felipe Balbi
> Sent:	Tue 12/4/2007 7:19 AM
> To:	ext Azhar Mr.
> Cc:	linux-omap-open-source@linux.omap.com
> Subject:	Re: MEASURING CURRENT DRAWN BY OMAP5912
> 
> On Tue, Dec 04, 2007 at 07:44:29AM +0000, ext Azhar Mr. wrote:
> > Hello Everyone,
> >    
> >           I want to measure the amount of current drawn by the OMAP 5912 board.
> >   Please somebody help me in providing the procedure to measure the current.
> >    
> >          I also want to measure the current when external devices like COMPACT FLASH, USB, WEBCAM, KEYPAD, GPS are connected to the OMAP5912.
> 
> Powering it up with an external controllable power supply is the best
> choice.
> 
> I mean those where you can set the voltage to source. Use on of those
> and you can read the current being drawn.
> 
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> felipe.lima@indt.org.br
> +55 92 2126-1003
> 
> INdT - OSMRC - Manaus
> Core Team
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br
+55 92 2126-1003

INdT - OSMRC - Manaus
Core Team
