From: "Yang, Xiaopeng" <xiaopeng.yang@windriver.com>
Subject: Re: ads7846: data read from tsc2046 are all zeros
Date: Fri, 09 Nov 2007 16:33:25 +0800
Message-ID: <47341B55.7030305@windriver.com>
References: <4732E60E.3000308@windriver.com>	<a46a26fd0711081357v72fa843dn3e7c2a43aa5492e2@mail.gmail.com>
	<4733D81D.4020907@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <4733D81D.4020907@windriver.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Yang, Xiaopeng" <xiaopeng.yang@windriver.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Resolved, the tsc2046 wouldn't be power on if the LCD module is not enabled.

Xiaopeng

Yang, Xiaopeng wrote:
> Hi all,
> 
> I captured the signals of the host-side pins of tsc2046, the SPI pins 
> and PENIRQ work correctly except DOUT remains LOW during CS is active. 
> That's why all read values are zore.
> 
> It seems like the tsc2046 doesn't work at all. I measured the voltage of 
> the power supply of tsc2046, the Vcc is only 0.93V. This shouldn't 
> happen in the normal operation. Maybe there is a switch to turn the 
> power on for tsc2046?
> 
> Thanks,
> Xiaopeng
> 
> Juha Kuikka wrote:
>> On 11/8/07, *Yang, Xiaopeng* <xiaopeng.yang@windriver.com 
>> <mailto:xiaopeng.yang@windriver.com>> wrote:
>>
>>     Hi all,
>>
>>     I'm working on the tsc2046 touchscreen controller (using ads7846
>>     driver) on
>>     sdp2430 v5.0.1 board. I can't get the touchscreen work with the
>>     linux-omap
>>     git tree. The driver builds, boots and register itself with no 
>> problem,
>>     interrupts can also be triggered when touching the panel, but no 
>> input
>>     events can be read. By enabling debug output, I finally found that
>>     all the
>>     values read from tsc2046 are all zeros.
>>
>>     Does anyone encounter the same problem? What could be the root cause
>>     for
>>     this problem? Any suggestions are welcome.
>>
>>
>> I'd check the pin muxes on the input (SPI I'm guessing) device you are 
>> using to connecto to tsc2046).
>> If still nothing I'd hook up logic analyzer to the SPI lines and see 
>> what's happening.
>>
>>  - Juha
>>
>> -- 
>> Madness takes it's toll. Please have exact change.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> 
