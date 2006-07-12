From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: iMate K-jam linux port
Date: Wed, 12 Jul 2006 17:17:20 +0200
Message-ID: <44B51280.20500@gmail.com>
References: <48a4d13c0607120447p7f9bd3c8j95551b18b2f0efdc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <48a4d13c0607120447p7f9bd3c8j95551b18b2f0efdc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Anand SVR <anand.svr@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Anand SVR wrote:
> I would like to port Linux onto i-mate K-JAM. If there is any effort
> already made in this regard
> can you please let me know where I can get a downloadable Linux
> bootloader, kernel image, and Linux distribution ? For beginners like
> me, is there a site that gives step-by-step procedure of porting Linux
> onto OMAP processor based devices like the one I have ?

Seems that i-mate K-JAM uses OMAP850? If this is correct, 
basic core support should be available in OMAP kernel. 
Search list archives for more info.

Regarding step-by-step procedure have a look to

Documentation/arm/OMAP/README

if you have already an OMAP kernel on disk, else

http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=f8ffb68e8588c5ad43a72c3534c5f963aa7c91af;hb=64929d882591a213cb51407992f28c42121b2f7d;f=Documentation/arm/OMAP/README

Best regards

Dirk
