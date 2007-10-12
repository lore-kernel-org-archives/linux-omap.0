From: Philippe Bollard <philippe.bollard@purplelabs.com>
Subject: Re: *** No rule to make target `omap_2430sdp_deconfig'.  Stop.
Date: Fri, 12 Oct 2007 09:14:11 +0200
Message-ID: <470F1EC3.4020903@purplelabs.com>
References: <FBD03D6DFE9D7C4893187AAE6DD77F0C1079C8@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <FBD03D6DFE9D7C4893187AAE6DD77F0C1079C8@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: aravind.boinpally@wipro.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello ,
maybe you should check you arch/arm/config repository .
The name of the config is "omap_2430sdp_defconfig" ,  not
"omap_2430sdp_deconfig"

Regards

philippe

aravind.boinpally@wipro.com wrote:
> Hi...
>  
> I am trying to compile the 2.6 kernel.I followed the following steps for
> compilation.
>  
> First i have made clean by using 
>  
>  make ARCH=arm
> CROSS_COMPILE=/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
> clean
>  
> then i configured the board for OMAP2430 using
>  
>  make ARCH=arm
> CROSS_COMPILE=/usr/local/arm/arm-2006q3/bin/arm-none-linux-gnueabi-
> omap_2430sdp_deconfig
>  
> But after doing this i am getting error like 
>  
>  
> make[1]: *** No rule to make target `omap_2430sdp_deconfig'.  Stop.
> make: *** [omap_2430sdp_deconfig] Error 2
>  
>  
> can u please suggest me what went wrong???
>  
> Thanking you.
>  
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>   
