From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Aic23 NULL pointer exception, was: Git tree updated to 2.6.19-rc2
Date: Sat, 28 Oct 2006 08:31:28 +0200
Message-ID: <4542F940.8020702@gmail.com>
References: <20061024075336.58475.qmail@web37901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061024075336.58475.qmail@web37901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Komal Shah wrote:
>>- Aic23 NULL pointer exception
> 
> Anything related to as discussed on davinci mailing list for I2C?

Oops is

Unable to handle kernel NULL pointer dereference at virtual 
address 00000004
PC is at i2c_smbus_write_byte_data+0x10/0x50
LR is at aic23_write_value+0x40/0x50

> http://linux.omap.com/pipermail/davinci-linux-open-source/2006-October/001312.html

I think this is the same?

> If that is the case, then please try adding zero-length transaction and
> SMBUS_QUICK code as temporary hack.

Anywhere a (hackish) patch for this available? Would be nice 
to have sound working again, even if a hack, until clean 
solution is available.

Best regards

Dirk
