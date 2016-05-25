From: Ravikumar Kattekola <rk@ti.com>
Subject: [RFC 0/1] i2c: omap: Add support for switching to slave mode
Date: Wed, 25 May 2016 19:41:18 +0530
Message-ID: <20160525141119.14486-1-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: tony@atomide.com, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

I2C controller on most of the omap devices has both master and slave
capability but the i2c framework has been missing support for registering
a bus in slave mode for long.
Recently the i2c slave support has been added to i2c framework, the following
patch adds the required support for omap_i2c driver to register a controller
as a slave device and be deriven by an external/internal master.

The slave interface requires us to add following mandatory events

1. I2C_SLAVE_WRITE_REQUESTED
2. I2C_SLAVE_READ_REQUESTED
3. I2C_SLAVE_WRITE_RECEIVED
4. I2C_SLAVE_READ_PROCESSED

and 

5. I2C_SLAVE_STOP

The omap i2c controller (at least on dra7x devices)
doesn't have  start/stop (STT/STP) support for slave mode
so event  #5 is not implemented in the driver.

Refer to Documentation/i2c/slave-interface for more info on 
i2c-slave-interface and Documentation/i2c/slave-eeprom-backend for 
sample backend driver.

Tested on:
DRA75x EVM Rev G3 and DRA72x EVM Rev B1 connected over i2c3 using DCAN2 lines [JP3]

Ravikumar Kattekola (1):
  drivers: i2c: omap: Add slave support

 drivers/i2c/busses/i2c-omap.c | 144 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

-- 
2.8.2.396.g5fe494c
