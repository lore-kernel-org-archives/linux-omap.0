From: Dirk Behme <dirk.behme@googlemail.com>
Subject: I2C zero length transfers and SMBUS_QUICK,
	was: Pending October patches
Date: Sun, 05 Nov 2006 11:32:39 +0100
Message-ID: <454DBDC7.70706@gmail.com>
References: <20061103105004.70334.qmail@web37904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061103105004.70334.qmail@web37904.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

 >Komal Shah wrote:
 >> --- Dirk Behme <dirk.behme@googlemail.com> wrote:
 >>>tony@atomide.com wrote:
>>>>26. [PATCH] ARM: OMAP: Make AIC23 sound work again
>>
>>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html
>>>
>>>Hmmm, I think there were some comments on this hack on LKML when we
>>>merged the driver?
>>
>>Komal, what do you think here?
>>
>>Anybody aware of someone working on a better solution? Any 
>>link to the LKML discussion about this?
>>
> Few links:
...
> http://linux.omap.com/pipermail/davinci-linux-open-source/2006-October/001332.html

Sounds to me a clean fix (new I2C stack?) will need some 
decades, if it comes at all. So, how to go one here?

Our hack to make things work on OMAP will not be accepted 
upstream. But staying with broken OMAP features only because 
(available) hack isn't acceptable in mainline doesn't sound 
like an option as well.

I personally vote for working OMAP ;)

Cheers

Dirk
