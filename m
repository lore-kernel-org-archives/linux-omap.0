From: Prashant <prashantkhoje@gmail.com>
Subject: Re: OMAP1710 H3: full duplex audio problem
Date: Thu, 14 Sep 2006 12:11:44 +0530
Message-ID: <7b1b9c8b0609132341k2f2547fbt7d379abe9e2cc344@mail.gmail.com>
References: <7b1b9c8b0609110333w565de1dckf47d5bfe982c24d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7b1b9c8b0609110333w565de1dckf47d5bfe982c24d3@mail.gmail.com>
Content-Disposition: inline
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

I have also tried using ioctls GETISPACE & GETOSPACE with and without
'select' function. Instead of loopback, if I feed some known test data
to be written to the device, device plays it. But recording doesnt
work whether I try
- to loopback,
- playback anything else than recorded data and dump recorded data to a file or
- only record opening device in read only mode


Simple "cat /dev/sound/dsp > /dev/sound/dsp" doesnt work either.

Regards,
Prashant Khoje
