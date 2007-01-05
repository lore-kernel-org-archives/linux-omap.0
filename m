From: "Lior Shiponi" <shiponi@gmail.com>
Subject: HDQ timing problem
Date: Fri, 5 Jan 2007 04:02:05 +0200
Message-ID: <fc0871f0701041802q6b93ead6j669fad0ae17979aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,

I have a strange problem with the HDQ.

There are two working kernels with the same HDQ driver, one of them is
2.6.15 the other one is 2.6.17.

In the first the HDQ works fine, I can see the rate of the bits with a
scope and each bit is about 100us. I transmit the command and receive
a response from the device.

In the second kernel (2.6.17) the length of the transmitted bits (OMAP
to the device) changes dramatically to about 30ms, and I guess it is
too slow for the device to understand it.

The clock (ARMXOR) is set to the same rate on both kernels.

The OMAP itself is responsible for the HDQ transmission (bit length,
etc.), so I really don't understand what is wrong here.

any idea ?


Thanks,
Lior Shiponi
