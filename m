From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Re: Write to file
Date: Mon, 7 Aug 2006 16:58:29 +0400
Message-ID: <9713be7f0608070558g7be2c6c2hafdf0a76cd5298a@mail.gmail.com>
References: <AOEAJEHKCJCLCFFMGNFDEEGICGAA.anantm@motechsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <AOEAJEHKCJCLCFFMGNFDEEGICGAA.anantm@motechsoftware.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi, Anant!

Why your application can't write the same directory where it is
located? You run application from NFS, right?
If you really need to remount root file system to RW, you can use the
following command
mount -n -o remount /

Sergey.
