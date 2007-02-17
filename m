From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: I2C TWL4030 Keypad
Date: Sat, 17 Feb 2007 07:45:11 -0600
Message-ID: <45D706E7.60301@gmail.com>
References: <8bf247760702160325m6624817bpbced2b76db9ae30a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8bf247760702160325m6624817bpbced2b76db9ae30a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Ram stated on 2/16/2007 5:25 AM:
> I also observe randomly (say 3 out of 10 times), my i2c bus times out and
> im unable to read or write TWL4030 registers. i get an return value of
> -110.
>
> i2c_omap i2c_omap.2: timeout waiting for bus ready
What is ur I2C speed configured? max u should be using is 2.6Mhz, u
could try and bump down to 400khz or so..further, which is the kernel
versions - this is not tested with rt patch..so there might be some
interesting things happening there.. :D
Regards,
Nishanth Menon
