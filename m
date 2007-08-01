From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: Regarding the I2C error
Date: Tue, 31 Jul 2007 20:27:46 -0500
Message-ID: <46AFE192.3000003@gmail.com>
References: <20070731142629.30975.qmail@f5mail11.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070731142629.30975.qmail@f5mail11.rediffmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balaji narayanam <narayanamb@rediffmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

balaji narayanam stated on 7/31/2007 9:26 AM:
>   
> But in the U-boot log we are not getting any OV7620 chip detected message. I am not getting any response at the i2c node in /dev/i2c-0 of OSK5912. 
> when I give  # cat /dev/i2c-0
> I am getting the following error
>
> i2c_omap i2c_omap.1: timeout waiting for bus ready
> cat: Read error: Connection timed out.
>   

Usually camera sensors need a power up sequence and clock before they
start responding on i2c.. am not sure of ov sensors.. micron does at
least... so u'd need to know the datasheet of the sensor to be sure at
what stage u can start communicating with the sensor in i2c. I usually
would do it in kernel as lots more things would be functional there..

Regards,
NM
