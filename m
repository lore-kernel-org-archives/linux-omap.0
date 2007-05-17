From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 09:10:40 -0500
Message-ID: <464C6260.6030302@css-design.us>
References: <57314e840705170639j410cdd26s40370f492fec6f00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <57314e840705170639j410cdd26s40370f492fec6f00@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Budhee,

I suggest you make sure that response is making it to the driver 
properly.  Find out which module is being used for your Ethernet 
controller and rebuild it with debug information.   This is likely a 
#define at the top of the file to set the debug level.  You may need to 
add a bit of code to print out all received packets' data.   I had a 
similar problem and doing this allowed me to trace the problem.  Sorry, 
but my problem was due to a custom board issue so it won't be yours.

Steve

Budhee Jamaich wrote:
> Hello list,
>
> I'm having networking problems with my OMAP.
>
> I tried a few booting schemes, but all failed.
> I tried DHCP auto-IP configurations and
> NFS root-fs, but they fail to connect to the server.
>
> When I'm running tcpdump on the server,
> I can see that the OMAP sends the "arp who-has x.x.x.x",
> looking for my server's MAC address,
> and I see the server's response: "arp reply x.x.x.x is-at 
> ZZ:ZZ:ZZ:ZZ:ZZ:ZZ (oui
> Unknown)",
>
> but the OMAP doesn't see the arp reply,
> and keep sending the arp who-has packets... :(
>
> anyone knows why this may be happening ?
> or any ideas how to debug this further ?
>
> Thank You All,
> Budhee
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
