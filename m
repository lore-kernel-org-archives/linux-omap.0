From: "jacky_wang" <jacky_wang@ovt.com.cn>
Subject: Re: status of camera port?
Date: Thu, 29 Nov 2007 17:42:47 -0800
Message-ID: <004301c832f2$4f8e9d40$9f4df780@jackywang>
References: <3634de740711270741i230c315bo4a384f147b883570@mail.gmail.com>
	<5d5443650711282327v289e917ct36df8122c24d3916@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>, Maximus <john.maximus@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Soni:

       I am working on 2430SDP to develop camera driver. I have not Micron 
sensor board . I designed my sensor board for developing OV 3M sensor on 
2430.I can handle all of sensor interface myself..but I found there some 
problem on 2430 v4l2 interface .Both read method and mmap method does not 
work when I used v4l2 application code to test it.
if possible I hope you can help me with this problem.


----- Original Message ----- 
From: "Trilok Soni" <soni.trilok@gmail.com>
To: "Maximus" <john.maximus@gmail.com>
Cc: <linux-omap-open-source@linux.omap.com>
Sent: Wednesday, November 28, 2007 11:27 PM
Subject: Re: status of camera port?


> Hi John,
>
> On Nov 27, 2007 9:11 PM, Maximus <john.maximus@gmail.com> wrote:
>> Hi,
>>  What is the current status of the camera port in the latest git
>> kernel for omap2430 sdp.
>>
>>  Could not find the micron camera sensor drivers for 2430 SDP in there.
>>
>>  Does anyone have a patch for the micron drivers with the latest v4l2 
>> changes.
>>
>
> I can convert that micron driver to latest v4l2-sensor interface, if
> you can help me in testing
> the sensor driver for 2430SDP, as I don't have access to 2430 boards.
>
> OR else you can start converting the same current micron sensor driver
> in TI tree
> by taking an example of ov9640 and toshiba sensor.
>
> -- 
> --Trilok Soni
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source 
