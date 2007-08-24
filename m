From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: CSST's load to ram feature
Date: Fri, 24 Aug 2007 15:05:42 -0500
Message-ID: <46CF3A16.5060106@gmail.com>
References: <3B6D69C3A9EBCA4BA5DA60D91302742901B8C883@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901B8C883@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard stated on 8/23/2007 8:31 PM:
>>
>> This feature works fine with the included example binaries 
>> but I am unable to use it to run x-loader or u-boot.
>>
>> I'm suspecting x-loader/u-boot do not work because they 
>> expect the system to be in a certain state but it is not.
>>
One possible condition is clock configurations. x-loader and u-boot
might expect a 19.2 Mhz sys clock, and configures accordginly while
possibly the uboot expects something like 26Meg or something.. am just
guessing here.. in theory, if every single configuration is being done
by the u-boot + x-loader combination and if the image is raw, all the
execute option does is to hand over control to the image, and this
should allow it to work.  As Richard mentioned, Lauterbach etc might
give you a better controlled environment for uboot and x-loader to work in.

Regards,
Nishanth Menon
