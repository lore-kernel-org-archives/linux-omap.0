From: Philip Balister <philip@balister.org>
Subject: Re: Building 2.6.18 kernel with openembedded
Date: Sat, 04 Nov 2006 07:45:46 -0500
Message-ID: <454C8B7A.20403@balister.org>
References: <W3550221177311991162635530@webmail20>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <W3550221177311991162635530@webmail20>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: chatchai@allit.info
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

What machine and distro files are you using? The OE list may be a better 
place for help with this issue. What hardware are you working with?

Philip

chatchai@allit.info wrote:
> Hi list
> 
> I have built both linux-omap-2.6.18-omap1.bb and linux-omap-2.8.28+git.bb. Both of them build successfully, but when I start a kernel, it said 
> 
> Uncompressing Kernel Image ... Error: inflate() returned -3
> GUNZIP ERROR - must RESET board to recover
> 
> So, I compiled a kernel from source using available in source directory (of openembedded), and using toolcain from openembedded, compile is successd,and booting is also work.
> 
> Everithing seem to work fine, but dropbear don't work. When I executed /etc/init.d/dropbear start, it said 
> 
> INIT: Entering runlevel: 5
> Starting Dropbear SSH server: Will output 1024 bit rsa secret key to '/etc/dropb
> ear/dropbear_rsa_host_key'
> Generating key, this may take a while...
> Exited: couldn't open random device
> 
> Please not that before this error, I got;
> INIT: version 2.86 booting
> .udev/ already exists on the static /dev!
> Starting the hotplug events dispatcher udevd
> mount: Mounting tmpfs on /dev failed: Invalid argument
> udev requires tmpfs support, not started.
> 
> Anybody experienced these kind of ploblem please tell me what is the ploblem.
> 
> Tanks and regard
> 
> Chatchai
> All Infomation Technologies, Thailand
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
